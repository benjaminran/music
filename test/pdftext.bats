#!/usr/bin/env bats
src=../bin/pdftext

function setup {
    source ${src}
}

function teardown {
    ;
}

@test "addition using bc" {
  result="$(echo 2+2 | bc)"
  [ "$result" -eq 4 ]
}

@test "addition using dc" {
  result="$(echo 2 2+p | dc)"
  [ "$result" -eq 4 ]
}

@test "invoking check_pdf with a nonexistent file prints an error" {
  run check_pdf nonexistent_filename
  [ "$status" -eq 1 ]
  echo "$output"
}
