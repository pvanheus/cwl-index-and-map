cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  reads: File[]
  genome: File
outputs:
  mapped_reads:
    type: File
    outputSource: bwa_mem/reads_stdout

steps:
  bwa_index:
    run: BWA-Index.cwl
    in:
      InputFile: genome
      IndexName:
        source: genome
        valueFrom: $(self.basename)
    out: [index]
  bwa_mem:
    run: BWA-Mem.cwl
    in:
      InputFile: reads
      Index: bwa_index/index
    out: [reads_stdout]

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl