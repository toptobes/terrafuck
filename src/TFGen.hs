module TFGen (genTfFiles) where

import Data.Text qualified as T
import FileActions
import Options
import Interpreter

data CombinedOpts = CombinedOpts
  { maxInterpSteps :: !Int
  , maxLUTGenSteps :: !Int
  , tapeLength :: !(Maybe Int)
  , code   :: !(Maybe Text)
  , input  :: !(Maybe Text)
  , outDir :: !FilePath
  , clean  :: !Bool
  }

genTfFiles :: Options -> FileActionF Text
genTfFiles opts = let opts' = combineOpts opts in do
  genTfFiles' opts' $> mkGenerationMessage opts'

mkGenerationMessage :: CombinedOpts -> Text
mkGenerationMessage CombinedOpts{..} = T.intercalate "\n" $
  [ "Generated terrafuck interpreter at '" <> toText outDir <> "'"
  , ""
  , "Interpreter was created with:"
  , " - " <> show maxInterpSteps <> " max interpretation steps" <> (code $> " (inferred)" ?: "")
  , " - " <> show maxLUTGenSteps <> " max bracket lut gen steps" <> (code $> " (inferred)" ?: "")
  , case tapeLength of
      Just len -> " - Default tape of length " <> show len <> (code $> " (inferred)" ?: "")
      Nothing  -> " - No default tape (must provide a tape explicitly clas a tfvar)"
  , case code of
      Just _  -> "\nThe provided code & inputs are set as defaults for the Terrafuck interpreter.\n"
      Nothing -> ""
  , "To run the interpreter, `cd` to '" <> toText outDir <> "' and do the following:"
  , " - Run `terraform init` to initialize the Terraform module"
  , " - Run `terraform plan` and input the variables you're prompted for"
  , case code of
      Just _  -> "   - Since you've already provided code/input, it won't prompt you for those nor a tape"
      Nothing -> case tapeLength of
        Just _  -> "   - Since you've already provided a default tape length, it won't prompt you for a tape"
        Nothing -> "   - You'll need to provide, at the very least, the brainfuck code, the input, and a tape"
  , "   - You can override any vars you weren't prompted for like so:"
  , "     - `terraform plan -var tape='[0, 0, 5, 0]'`"
  , "   - You can find all possible inputs in the `main.tf` file in the output directory"
  , ""
  , "Once you run the `plan` command, you can see the output, tape, and other debug variables in the outputed fields."
  , " - If you feel like committing, you can run `terraform apply` the same way you'd run `plan`."
  , ""
  , "This is also able to used as a normal Terraform module from within your own Terraform code."
  ]

combineOpts :: Options -> CombinedOpts
combineOpts Options{..} = case config of
  ManualConfig{..} -> CombinedOpts
    { maxInterpSteps = maxInterpSteps
    , maxLUTGenSteps = maxLUTGenSteps
    , tapeLength = tapeLength
    , code   = Nothing
    , input  = Nothing
    , outDir = outDir
    , clean  = clean
    }
  ConfigFromCode{..} -> case eval code (fromMaybe "" input) of
    Left  err -> error $ show err
    Right res -> CombinedOpts
      { maxInterpSteps = res.interpSteps
      , maxLUTGenSteps = res.lutGenSteps
      , tapeLength = Just res.maxTapeLen
      , code   = Just code
      , input  = input
      , outDir = outDir
      , clean  = clean
      }

genTfFiles' :: CombinedOpts -> FileActionF ()
genTfFiles' opts = do
  when opts.clean $ do
    deleteDir opts.outDir
  mkRoot opts

generationNotice :: Text
generationNotice = ""
  <> "########################################################################\n"
  <> "# This file was auto-generated by the Terrafuck CLI                    #\n"
  <> "# https://github.com/toptobes/terrform-brainfuck-interpreter           #\n"
  <> "#                                                                      #\n"
  <> "# (please send help I'm locked in his basement being forced to re-type #\n"
  <> "# all of this by hand each time the CLI is called or he won't feed me) #\n"
  <> "########################################################################\n"

mkRoot :: CombinedOpts -> FileActionF ()
mkRoot opts = do
  entryTemplate <- mkRootFileTemplate opts
  let entryFile = FileDesc "main.tf" (generationNotice <> "\n" <> entryTemplate)

  dirs <- sequence
    [ mkTemplateModule "interpreter" opts.maxInterpSteps
    , mkTemplateModule "bracket_lut" opts.maxLUTGenSteps
    ]

  createDir $ DirDesc opts.outDir [entryFile] dirs

mkRootFileTemplate :: CombinedOpts -> FileActionF Text
mkRootFileTemplate opts = useTemplateFile "root/main.tf"
  [ ("maybe_default_tape", maybeDefaultTape)
  , ("maybe_default_code", maybeDefaultCode)
  , ("default_input", defaultInput)
  ]
  where
    maybeDefaultTape = maybe "" (\l -> "\n  default     = " <> show (replicate @Int l 0)) opts.tapeLength
    maybeDefaultCode = maybe "" (\c -> "\n  default     = " <> show c) opts.code
    defaultInput = show $ fromMaybe "" opts.input

mkTemplateModule :: FilePath -> Int -> FileActionF DirDesc
mkTemplateModule name size = do
  contentStart <- useTemplateFile (name <> "/start.tf") []

  contentIntermediate <- forM [1..size] $ \i -> do
    useTemplateFile (name <> "/step.tf") [("i", show i), ("pi", show $ i - 1)]

  contentEnd <- useTemplateFile (name <> "/end.tf") [("pi", show size)]

  let content = T.intercalate "\n" $ concat [[generationNotice, contentStart], contentIntermediate, [contentEnd]]
      mainFile = FileDesc "main.tf" content

  pure $ DirDesc ("modules/" <> name) [mainFile] []
