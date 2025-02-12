
module sha_core (
  input m_axis_aclk, 
  input m_axis_aresetn, 

  /* input data channel */
  input s_axis_tvalid,
  input [3:0] s_axis_tkeep,
  output reg s_axis_tready,
  input [31:0] s_axis_tdata,
  input s_axis_tlast,

  /* output data channel */
  output reg m_axis_tvalid,
  output wire [3:0] m_axis_tkeep,
  input m_axis_tready,
  output reg [31:0] m_axis_tdata,
  output reg m_axis_tlast
);

import package_file::*;
logic data_recieved;
logic s_axis_tlast_2d,s_axis_tlast_d;

array_80_64 word_data,konst_value;
logic [63:0] wdata;
fsm_state state, next_state;

hash_buffer_storage hash_buffer,in_hash_buffer,out_hash_buffer;


always_ff @(posedge m_axis_aclk) begin
    if(!m_axis_aresetn) begin
        state <= IDLE;
    end 
    else begin
        state <= next_state;
    end
end
logic [3:0] counter;
always_comb begin 
    if(!m_axis_aresetn)
        wdata = 'b0;
    else begin
        case (state)
            IDLE : if(s_axis_tvalid && m_axis_tready) begin
                wdata[31:0] = s_axis_tdata;
                next_state = SECOND_DATA;
            end 
            FIRST_DATA : begin
                if(s_axis_tvalid && m_axis_tready) begin
                    wdata[31:0] = s_axis_tdata;
                    next_state = SECOND_DATA;
                end else begin
                    next_state = IDLE;
                end     
            end

            SECOND_DATA : begin
                if(s_axis_tvalid && m_axis_tready) begin
                    wdata[63:32] = s_axis_tdata;
                    if(!s_axis_tlast)
                        next_state = FIRST_DATA;
                    else 
                        next_state = IDLE;
                end else begin
                    next_state = IDLE;
                end     
            end
        endcase
    end
end
logic counter_val_d;
logic counter_val_2d;
always_ff @(posedge m_axis_aclk) begin
    if(!m_axis_aresetn) begin
        s_axis_tlast_d <= 'b0;
        s_axis_tlast_2d <= 'b0;
        counter_val_d <= 'b0;
        counter_val_2d <= 'b0;
    end else begin
        counter_val_d <= counter_val;
        counter_val_2d <= counter_val_d;
        s_axis_tlast_d <= s_axis_tlast;
        s_axis_tlast_2d <= s_axis_tlast_d;
    end
end

logic [63:0]w_data[0:15];

always_ff @(posedge m_axis_aclk) begin
    if(!m_axis_aresetn) begin
        counter <= 'b0;
        w_data <= '{default: '0};
        s_axis_tready <= 1'b1;
    end else if(state == SECOND_DATA) begin
        counter <= counter + 1;
        w_data[counter] <= wdata;
    end else 
        counter <= counter;
end

assign counter_val = &counter;

always_comb begin
    if(!m_axis_aresetn) begin
        INIT_KONST(konst_value);
        hash_buffer = '{a : 64'h6A09E667F3BCC908, b : 64'hBB67AE8584CAA73B, c : 64'h3C6EF372FE94F82B, d : 64'hA54FF53A5F1D36F1, e : 64'h510E527FADE682D1, f : 64'h9B05688C2B3E6C1F, g : 64'h1F83D9ABFB41BD6B, h: 64'h5BE0CD19137E2179};
        out_hash_buffer = hash_buffer;
        in_hash_buffer = hash_buffer; 
    end
    else begin
        //@(posedge counter_val_2d);
        if(counter_val_2d && counter_val_d) begin
            word_cal(w_data,word_data);
            foreach(konst_value[i]) begin
                mssg_word_cal(in_hash_buffer,out_hash_buffer,word_data[i],konst_value[i]);
                in_hash_buffer = out_hash_buffer;
                //@(posedge m_axis_aclk);
            end
            in_hash_buffer = out_hash_buffer + hash_buffer;
            hash_buffer = out_hash_buffer;
        end else begin
            if(s_axis_tlast_2d) 
                m_axis_tdata = in_hash_buffer;
        end
    end
end

endmodule 