#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fastq_reduce)
      - $(inputs.query_fastq)
baseCommand: ['perl', 'fastq_reduce', 'query.fastq', '5']

stdout: perl.out
stderr: perl.err

inputs:
  fastq_reduce:
    type: File
  query_fastq:
    type: File
  
outputs:
  query_fastq_0:
    outputBinding:
      glob: "query.fastq.0"
    type: File
  query_fastq_1:
    outputBinding:
      glob: "query.fastq.1"
    type: File
  query_fastq_2:
    outputBinding:
      glob: "query.fastq.2"
    type: File
  query_fastq_3:
    outputBinding:
      glob: "query.fastq.3"
    type: File
  query_fastq_4:
    outputBinding:
      glob: "query.fastq.4"
    type: File
  stde:
    type: stderr
  stdout:
    type: stdout
  
