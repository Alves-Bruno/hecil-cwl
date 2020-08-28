#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.mem_0_err)
      - $(inputs.mem_1_err)
      - $(inputs.mem_2_err)
      - $(inputs.mem_3_err)
      - $(inputs.mem_4_err)
baseCommand: ['cat']

stdout: mem.err

inputs:
  mem_0_err:
    inputBinding:
      position: 1
    type: File
  mem_1_err:
    inputBinding:
      position: 2
    type: File
  mem_2_err:
    inputBinding:
      position: 3
    type: File
  mem_3_err:
    inputBinding:
      position: 4
    type: File
  mem_4_err:
    inputBinding:
      position: 5
    type: File
  
outputs:
  stdo:
    type: stdout
  
