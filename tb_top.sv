`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 07:39:53 PM
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

interface sha_intf;
    logic clk,rst;
    logic [31:0] slave_data;
    logic slave_valid,slave_ready,slave_last,master_ready;
    logic [511:0]master_data;
    logic master_valid;
endinterface

class tranmission;
    logic [23:0] data;
endclass

class driver;
    virtual sha_intf intf;
    logic [1023:0] temp;
    int i = 0;

    function new(virtual sha_intf intf);
        this.intf = intf;
      temp = 1024'h6162638000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000018;
    //    temp = 1024'h5468652071756963_6b2062726f776e20_666f78206a756d70_73206f7665722074_6865206c617a7920_646f672e80000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000000_0000000000000160;    
    endfunction  

    task reset;
        @(posedge intf.clk);
        intf.rst <= 1'b0;
        repeat(10) @(posedge intf.clk);
        intf.rst <= 1'b1;
    endtask

    task run();
        intf.slave_last <= 1'b0;
        //intf.slave_data <= 24'b01100001_01100010_01100011;
        //@(posedge intf.clk);
        intf.slave_valid <= 1'b0;
        intf.slave_data <= 'b0;
        intf.slave_last <= 1'b0;
        @(posedge intf.clk);
        intf.rst <= 1'b1;
        while(!intf.slave_ready) @(posedge intf.clk);
            while(i<32) begin
                @(posedge intf.clk);
                intf.slave_valid <= 1'b1;
                intf.slave_data <= temp[31:0];
                temp = {32'b0,temp[1023:32]};
                i++;
            end
        //end
        //intf.slave_data <= temp[1023];
        intf.slave_last <= 1'b1;
        //intf.slave_data <= 24'b01100001_01100010_01100011;
        @(posedge intf.clk);
        intf.slave_valid <= 1'b0;
        intf.slave_data <= 'b0;
        intf.slave_last <= 1'b0;
    endtask

endclass 


module tb_top();
    
    sha_intf intf();
    driver drv;
    
    initial begin
        intf.clk <= 1'b0;
        intf.master_ready <= 1'b1;
        forever begin
            #5 intf.clk <= !intf.clk;
        end
    end 

    initial begin
        drv = new(intf);
        drv.reset();
        drv.run();
    end

    initial begin
        #250;
        $finish;
    end
    
    sha_core top_inst(.m_axis_aclk(intf.clk),.m_axis_aresetn(intf.rst),.s_axis_tdata(intf.slave_data),.s_axis_tlast(intf.slave_last),.s_axis_tvalid(intf.slave_valid),.s_axis_tready(intf.slave_ready),.m_axis_tready(intf.master_ready),.m_axis_tdata(intf.master_data),.m_axis_tvalid(intf.master_valid));

endmodule
