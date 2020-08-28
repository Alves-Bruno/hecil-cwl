#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.lc)
      - $(inputs.corr_err)
baseCommand: ['echo', '""', '>>', 'lc.out', ';', 'echo', '""', '>>', 'corr.err']


inputs:
  corr_err:
    type: File
  lc:
    type: File
  
outputs:
  corr_err_out:
    outputBinding:
      glob: "corr.err"
    type: File
  lc_out:
    outputBinding:
      glob: "lc.out"
    type: File
  
