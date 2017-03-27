#!/usr/bin/env bats
src=../bin/lib.sh

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
