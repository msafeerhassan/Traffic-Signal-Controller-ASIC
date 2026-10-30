import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 9

    await ClockCycles(dut.clk, 99998)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 9

    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 12
    
    await ClockCycles(dut.clk, 499999)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 12
        
    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 10
    
    await ClockCycles(dut.clk, 299999)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 10

    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 9

    await ClockCycles(dut.clk, 99999)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 9

    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 33

    await ClockCycles(dut.clk, 499999)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 33

    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 17
    
    await ClockCycles(dut.clk, 299999)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 17

    await ClockCycles(dut.clk, 1)
    await Timer(1, 'ns')
    assert int(dut.uo_out.value) == 9