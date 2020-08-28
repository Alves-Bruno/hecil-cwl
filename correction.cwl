#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.Correction_py)
      - $(inputs.Pileup_set)
      - $(inputs.ref_fasta)
      - $(inputs.Out_sam)
baseCommand: ['python', 'Correction.py', 'Pileup_Set', 'ref.fasta', 'lc.out', 'Out.sam', '5']

stdout: corr.out
stderr: corr.err

inputs:
  Correction_py:
    type: File
  Out_sam:
    type: File
  Pileup_set:
    inputBinding:
      position: 2
    type: File
  ref_fasta:
    type: File
  
outputs:
  lc_out:
    outputBinding:
      glob: "lc.out"
    type: File
  stde:
    type: stderr
  stdo:
    type: stdout
  
