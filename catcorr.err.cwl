#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.corr_0)
      - $(inputs.corr_1)
baseCommand: ['cat']

stdout: corr.err

inputs:
  corr_0:
    inputBinding:
      position: 1
    type: File
  corr_1:
    inputBinding:
      position: 2
    type: File
  
outputs:
  stdo:
    type: stdout
  
