# Traffic Signal Controller ASIC

## Built using Verilog

### What, How and Why?

I made this simple Traffic Signal Controller ASIC just to gain experience and knowledge of designing a chip. This basic traffic controller has two general outputs - one time, the North-South Signal is green while East-West is red while the other time, East-West signal is Green and North-South signal is red. Each green signal stays up for 5 seconds, the yellow signal stays up for 3 seconds. For 1 second, the both signals stays red for practical safety.

### Test Cases

The test cases can be run by running the command `py run_test.py` in OSS CAD. The test cases verifies that the signal stays in the expected state for exact expected time - doesn't changes state before or after the expected interval.

### Setup

You are supposed to have OSS CAD Suite, Python and cocotb and such dependencies pre-installed for it's working.

1. Clone this repository.
2. Open OSS CAD Suite Termial and navigate to this project's root directory.
3. Run `py run_test.py` to ensure it works perfectly.
4. Then you can open the generated waveform using GTKWave and analyze it.