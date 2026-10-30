`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

reg [2:0] state;
reg [18:0] timer;
reg [5:0] lights;

localparam nsGreen = 3'b000;
localparam nsYellow = 3'b001;
localparam allRedToEW = 3'b010;
localparam ewGreen = 3'b011;
localparam ewYellow = 3'b100;
localparam allRedToNS = 3'b101;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state <= allRedToNS;
    timer <= 0;
  end
  else begin
    case (state)
      allRedToNS : begin
        if (timer >= 99999) begin
          state <= nsGreen;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end 
      nsGreen : begin
        if (timer >= 499999) begin
          state <= nsYellow;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end
      nsYellow : begin
        if (timer >= 299999) begin
          state <= allRedToEW;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end
      allRedToEW : begin
        if (timer >= 99999) begin
          state <= ewGreen;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end
      ewGreen : begin
        if (timer >= 499999) begin
          state <= ewYellow;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end
      ewYellow : begin
        if (timer >= 299999) begin
          state <= allRedToNS;
          timer <= 0;
        end else begin
          timer <= timer + 1;
        end
      end
      default: begin
        timer <= 0;
        state <= allRedToNS;
      end
    endcase
  end
end

always @(*) begin
  case (state)
    allRedToNS: lights = 6'b001001;
    nsGreen: lights = 6'b001100;
    nsYellow: lights = 6'b001010;
    allRedToEW: lights = 6'b001001;
    ewGreen: lights = 6'b100001;
    ewYellow: lights = 6'b010001;
    default: lights = 6'b001001;
  endcase     
end

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = {2'b00, lights};
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
