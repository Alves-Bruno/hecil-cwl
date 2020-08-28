#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pileup_txt)
      - $(inputs.Create_SubsetPileup)
      - $(inputs.Split_Pileup)
baseCommand: ['./Split_Pileup.sh', 'pileup.txt', '2']

stderr: Split_Pileup.err

inputs:
  Create_SubsetPileup:
    type: File
  Split_Pileup:
    type: File
  pileup_txt:
    type: File
  
outputs:
  Pileup_Set1:
    outputBinding:
      glob: "Pileup_Set1.txt"
    type: File
  Pileup_Set2:
    outputBinding:
      glob: "Pileup_Set2.txt"
    type: File
  stde:
    type: stderr
  
