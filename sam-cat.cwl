#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sam_cat_file)
      - $(inputs.Out_0_sam)
      - $(inputs.Out_1_sam)
      - $(inputs.Out_2_sam)
      - $(inputs.Out_3_sam)
      - $(inputs.Out_4_sam)
baseCommand: ['bash', 'sam_cat.sh', 'Out.*.sam']

stdout: Out.sam

inputs:
  Out_0_sam:
    type: File
  Out_1_sam:
    type: File
  Out_2_sam:
    type: File
  Out_3_sam:
    type: File
  Out_4_sam:
    type: File
  sam_cat_file:
    type: File
  
outputs:
  stdo:
    type: stdout
  
