import os
from cocotb_test.simulator import run

ROOT = os.path.dirname(os.path.abspath(__file__))

run(
    simulator="icarus",
    verilog_sources=[
        os.path.join(ROOT, "src", "project.v"),
        os.path.join(ROOT, "test", "tb.v"),
    ],
    toplevel="tb",
    module="test.test",
    python_search=[ROOT],
    sim_build=os.path.join(ROOT, "sim_build"),
)