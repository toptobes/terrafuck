########################################################################
# This file was auto-generated by the Terrafuck CLI                    #
# https://github.com/toptobes/terrform-brainfuck-interpreter           #
#                                                                      #
# (please send help I'm locked in his basement being forced to re-type #
# all of this by hand each time the CLI is called or he won't feed me) #
########################################################################

variable "code" {}

locals {
  idx_0     = -1
  abs_idx_0 = -1
  code_0    = var.code
  depth_0   = 0
  lut_0     = []
}

locals {
  idx_1 = min(try(index(local.code_0, "["), 999999999), try(index(local.code_0, "]"), 999999999))

  code_1 = (local.idx_1 != 999999999
    ? slice(local.code_0, local.idx_1 + 1, length(local.code_0))
    : null)
    
  abs_idx_1 = local.idx_1 + local.abs_idx_0 + 1

  lut_1 = local.idx_1 == 999999999 ? local.lut_0 : (
    (try(index(local.code_0, "["), null) == local.idx_1 
      ? concat([[local.abs_idx_1]], local.lut_0) 
      : [for p in local.lut_0 : (p[0] == [for p2 in local.lut_0 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_1] : p)])
  )
}

locals {
  idx_2 = min(try(index(local.code_1, "["), 999999999), try(index(local.code_1, "]"), 999999999))

  code_2 = (local.idx_2 != 999999999
    ? slice(local.code_1, local.idx_2 + 1, length(local.code_1))
    : null)
    
  abs_idx_2 = local.idx_2 + local.abs_idx_1 + 1

  lut_2 = local.idx_2 == 999999999 ? local.lut_1 : (
    (try(index(local.code_1, "["), null) == local.idx_2 
      ? concat([[local.abs_idx_2]], local.lut_1) 
      : [for p in local.lut_1 : (p[0] == [for p2 in local.lut_1 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_2] : p)])
  )
}

locals {
  idx_3 = min(try(index(local.code_2, "["), 999999999), try(index(local.code_2, "]"), 999999999))

  code_3 = (local.idx_3 != 999999999
    ? slice(local.code_2, local.idx_3 + 1, length(local.code_2))
    : null)
    
  abs_idx_3 = local.idx_3 + local.abs_idx_2 + 1

  lut_3 = local.idx_3 == 999999999 ? local.lut_2 : (
    (try(index(local.code_2, "["), null) == local.idx_3 
      ? concat([[local.abs_idx_3]], local.lut_2) 
      : [for p in local.lut_2 : (p[0] == [for p2 in local.lut_2 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_3] : p)])
  )
}

locals {
  idx_4 = min(try(index(local.code_3, "["), 999999999), try(index(local.code_3, "]"), 999999999))

  code_4 = (local.idx_4 != 999999999
    ? slice(local.code_3, local.idx_4 + 1, length(local.code_3))
    : null)
    
  abs_idx_4 = local.idx_4 + local.abs_idx_3 + 1

  lut_4 = local.idx_4 == 999999999 ? local.lut_3 : (
    (try(index(local.code_3, "["), null) == local.idx_4 
      ? concat([[local.abs_idx_4]], local.lut_3) 
      : [for p in local.lut_3 : (p[0] == [for p2 in local.lut_3 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_4] : p)])
  )
}

locals {
  idx_5 = min(try(index(local.code_4, "["), 999999999), try(index(local.code_4, "]"), 999999999))

  code_5 = (local.idx_5 != 999999999
    ? slice(local.code_4, local.idx_5 + 1, length(local.code_4))
    : null)
    
  abs_idx_5 = local.idx_5 + local.abs_idx_4 + 1

  lut_5 = local.idx_5 == 999999999 ? local.lut_4 : (
    (try(index(local.code_4, "["), null) == local.idx_5 
      ? concat([[local.abs_idx_5]], local.lut_4) 
      : [for p in local.lut_4 : (p[0] == [for p2 in local.lut_4 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_5] : p)])
  )
}

locals {
  idx_6 = min(try(index(local.code_5, "["), 999999999), try(index(local.code_5, "]"), 999999999))

  code_6 = (local.idx_6 != 999999999
    ? slice(local.code_5, local.idx_6 + 1, length(local.code_5))
    : null)
    
  abs_idx_6 = local.idx_6 + local.abs_idx_5 + 1

  lut_6 = local.idx_6 == 999999999 ? local.lut_5 : (
    (try(index(local.code_5, "["), null) == local.idx_6 
      ? concat([[local.abs_idx_6]], local.lut_5) 
      : [for p in local.lut_5 : (p[0] == [for p2 in local.lut_5 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_6] : p)])
  )
}

locals {
  idx_7 = min(try(index(local.code_6, "["), 999999999), try(index(local.code_6, "]"), 999999999))

  code_7 = (local.idx_7 != 999999999
    ? slice(local.code_6, local.idx_7 + 1, length(local.code_6))
    : null)
    
  abs_idx_7 = local.idx_7 + local.abs_idx_6 + 1

  lut_7 = local.idx_7 == 999999999 ? local.lut_6 : (
    (try(index(local.code_6, "["), null) == local.idx_7 
      ? concat([[local.abs_idx_7]], local.lut_6) 
      : [for p in local.lut_6 : (p[0] == [for p2 in local.lut_6 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_7] : p)])
  )
}

locals {
  idx_8 = min(try(index(local.code_7, "["), 999999999), try(index(local.code_7, "]"), 999999999))

  code_8 = (local.idx_8 != 999999999
    ? slice(local.code_7, local.idx_8 + 1, length(local.code_7))
    : null)
    
  abs_idx_8 = local.idx_8 + local.abs_idx_7 + 1

  lut_8 = local.idx_8 == 999999999 ? local.lut_7 : (
    (try(index(local.code_7, "["), null) == local.idx_8 
      ? concat([[local.abs_idx_8]], local.lut_7) 
      : [for p in local.lut_7 : (p[0] == [for p2 in local.lut_7 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_8] : p)])
  )
}

locals {
  idx_9 = min(try(index(local.code_8, "["), 999999999), try(index(local.code_8, "]"), 999999999))

  code_9 = (local.idx_9 != 999999999
    ? slice(local.code_8, local.idx_9 + 1, length(local.code_8))
    : null)
    
  abs_idx_9 = local.idx_9 + local.abs_idx_8 + 1

  lut_9 = local.idx_9 == 999999999 ? local.lut_8 : (
    (try(index(local.code_8, "["), null) == local.idx_9 
      ? concat([[local.abs_idx_9]], local.lut_8) 
      : [for p in local.lut_8 : (p[0] == [for p2 in local.lut_8 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_9] : p)])
  )
}

locals {
  idx_10 = min(try(index(local.code_9, "["), 999999999), try(index(local.code_9, "]"), 999999999))

  code_10 = (local.idx_10 != 999999999
    ? slice(local.code_9, local.idx_10 + 1, length(local.code_9))
    : null)
    
  abs_idx_10 = local.idx_10 + local.abs_idx_9 + 1

  lut_10 = local.idx_10 == 999999999 ? local.lut_9 : (
    (try(index(local.code_9, "["), null) == local.idx_10 
      ? concat([[local.abs_idx_10]], local.lut_9) 
      : [for p in local.lut_9 : (p[0] == [for p2 in local.lut_9 : p2 if length(p2) == 1][0][0] ? [p[0], local.abs_idx_10] : p)])
  )
}

output "lut" {
  value = merge({
    for p in local.lut_10 : tostring(p[0]) => p[1]
  }, {
    for p in local.lut_10 : tostring(p[1]) => p[0]
  })
}
