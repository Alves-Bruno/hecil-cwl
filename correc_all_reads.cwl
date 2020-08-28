#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.Create_Corrected_All_Reads)
      - $(inputs.ref_fasta_i)
      - $(inputs.corr_out)
baseCommand: ['python']

stderr: create.err

inputs:
  Create_Corrected_All_Reads:
    inputBinding:
      position: 1
    type: File
  corr_out:
    inputBinding:
      position: 3
    type: File
  ref_fasta_i:
    inputBinding:
      position: 2
    type: File
  
outputs:
  stde:
    type: stderr
  
