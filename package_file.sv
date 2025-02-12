package package_file;

    typedef enum {IDLE,FIRST_DATA,SECOND_DATA} fsm_state;
    typedef logic [63:0] array_80_64 [0:79];
 
    typedef struct packed {
        logic [63:0] a;
        logic [63:0] b;
        logic [63:0] c;
        logic [63:0] d;
        logic [63:0] e;
        logic [63:0] f;
        logic [63:0] g;
        logic [63:0] h;
    }hash_buffer_storage;


   task automatic INIT_KONST(output array_80_64 konst_value);
        konst_value[0] = 64'h428a2f98d728ae22;
        konst_value[1] = 64'h7137449123ef65cd;
        konst_value[2] = 64'hb5c0fbcfec4d3b2f;
        konst_value[3] = 64'he9b5dba58189dbbc;
        konst_value[4] = 64'h3956c25bf348b538;
        konst_value[5] = 64'h59f111f1b605d019;
        konst_value[6] = 64'h923f82a4af194f9b;
        konst_value[7] = 64'hab1c5ed5da6d8118;
        konst_value[8] = 64'hd807aa98a3030242;
        konst_value[9] = 64'h12835b0145706fbe;
        // Next 10 : 
        konst_value[10] = 64'h243185be4ee4b28c;
        konst_value[11] = 64'h550c7dc3d5ffb4e2;
        konst_value[12] = 64'h72be5d74f27b896f;
        konst_value[13] = 64'h80deb1fe3b1696b1;
        konst_value[14] = 64'h9bdc06a725c71235;
        konst_value[15] = 64'hc19bf174cf692694;
        konst_value[16] = 64'he49b69c19ef14ad2;
        konst_value[17] = 64'hefbe4786384f25e3;
        konst_value[18] = 64'h0fc19dc68b8cd5b5;
        konst_value[19] = 64'h240ca1cc77ac9c65;
        // Next 20 : 
        konst_value[20] = 64'h2de92c6f592b0275;
        konst_value[21] = 64'h4a7484aa6ea6e483;
        konst_value[22] = 64'h5cb0a9dcbd41fbd4;
        konst_value[23] = 64'h76f988da831153b5;
        konst_value[24] = 64'h983e5152ee66dfab;
        konst_value[25] = 64'ha831c66d2db43210;
        konst_value[26] = 64'hb00327c898fb213f;
        konst_value[27] = 64'hbf597fc7beef0ee4;
        konst_value[28] = 64'hc6e00bf33da88fc2;
        konst_value[29] = 64'hd5a79147930aa725;
        // Next 30 : 
        konst_value[30] = 64'h06ca6351e003826f;
        konst_value[31] = 64'h142929670a0e6e70;
        konst_value[32] = 64'h27b70a8546d22ffc;
        konst_value[33] = 64'h2e1b21385c26c926;
        konst_value[34] = 64'h4d2c6dfc5ac42aed;
        konst_value[35] = 64'h53380d139d95b3df;
        konst_value[36] = 64'h650a73548baf63de;
        konst_value[37] = 64'h766a0abb3c77b2a8;
        konst_value[38] = 64'h81c2c92e47edaee6;
        konst_value[39] = 64'h92722c851482353b;
        // Next 40 : 
        konst_value[40] = 64'ha2bfe8a14cf10364;
        konst_value[41] = 64'ha81a664bbc423001;
        konst_value[42] = 64'hc24b8b70d0f89791;
        konst_value[43] = 64'hc76c51a30654be30;
        konst_value[44] = 64'hd192e819d6ef5218;
        konst_value[45] = 64'hd69906245565a910;
        konst_value[46] = 64'hf40e35855771202a;
        konst_value[47] = 64'h106aa07032bbd1b8;
        konst_value[48] = 64'h19a4c116b8d2d0c8;
        konst_value[49] = 64'h1e376c085141ab53;
        // Next 50 : 
        konst_value[50] = 64'h2748774cdf8eeb99;
        konst_value[51] = 64'h34b0bcb5e19b48a8;
        konst_value[52] = 64'h391c0cb3c5c95a63;
        konst_value[53] = 64'h4ed8aa4ae3418acb;
        konst_value[54] = 64'h5b9cca4f7763e373;
        konst_value[55] = 64'h682e6ff3d6b2b8a3;
        konst_value[56] = 64'h748f82ee5defb2fc;
        konst_value[57] = 64'h78a5636f43172f60;
        konst_value[58] = 64'h84c87814a1f0ab72;
        konst_value[59] = 64'h8cc702081a6439ec;
        // Next 60 : 
        konst_value[60] = 64'h90befffa23631e28;
        konst_value[61] = 64'ha4506cebde82bde9;
        konst_value[62] = 64'hbef9a3f7b2c67915;
        konst_value[63] = 64'hc67178f2e372532b;
        konst_value[64] = 64'hca273eceea26619c;
        konst_value[65] = 64'hd186b8c721c0c207;
        konst_value[66] = 64'heada7dd6cde0eb1e;
        konst_value[67] = 64'hf57d4f7fee6ed178;
        konst_value[68] = 64'h06f067aa72176fba;
        konst_value[69] = 64'h0a637dc5a2c898a6;
        // Next 70 : 
        konst_value[70] = 64'h113f9804bef90dae;
        konst_value[71] = 64'h1b710b35131c471b;
        konst_value[72] = 64'h28db77f523047d84;
        konst_value[73] = 64'h32caab7b40c72493;
        konst_value[74] = 64'h3c9ebe0a15c9bebc;
        konst_value[75] = 64'h431d67c49c100d4c;
        konst_value[76] = 64'h4cc5d4becb3e42b6;
        konst_value[77] = 64'h597f299cfc657e2a;
        konst_value[78] = 64'h5fcb6fab3ad6faec;
        konst_value[79] = 64'h6c44198c4a475817;

    endtask
    

    function automatic [63:0] Ch(input hash_buffer_storage in_hash_buffer);
        Ch = (in_hash_buffer.e & in_hash_buffer.f) ^ (~in_hash_buffer.e & in_hash_buffer.g);
    endfunction

    function automatic [63:0] t_one(input hash_buffer_storage in_hash_buffer, input logic [63:0] word_data,konst_value);
        t_one = in_hash_buffer.h + Ch(in_hash_buffer) + (ROTR(in_hash_buffer.e,6'd14)^ROTR(in_hash_buffer.e,6'd18)^ROTR(in_hash_buffer.e,6'd41)) + word_data + konst_value;
    endfunction

    function automatic [63:0] t_two(input hash_buffer_storage in_hash_buffer);
        t_two = (ROTR(in_hash_buffer.a,6'd28)^ROTR(in_hash_buffer.a,6'd34)^ROTR(in_hash_buffer.a,6'd39)) + Maj(in_hash_buffer);
    endfunction

  

    function automatic [63:0] Maj(input hash_buffer_storage in_hash_buffer);
        Maj = (in_hash_buffer.a & in_hash_buffer.b) ^ (in_hash_buffer.a & in_hash_buffer.c) ^ (in_hash_buffer.b & in_hash_buffer.c);
    endfunction

    task automatic mssg_word_cal (input hash_buffer_storage in_hash_buffer, output hash_buffer_storage out_hash_buffer, input logic [63:0] word_data,konst_value);
        out_hash_buffer.h = in_hash_buffer.g;
        out_hash_buffer.g = in_hash_buffer.f;
        out_hash_buffer.f = in_hash_buffer.e;
        out_hash_buffer.e = in_hash_buffer.d + t_one(in_hash_buffer,word_data,konst_value);
        out_hash_buffer.d = in_hash_buffer.c;
        out_hash_buffer.c = in_hash_buffer.b;
        out_hash_buffer.b = in_hash_buffer.a;
        out_hash_buffer.a = t_one(in_hash_buffer,word_data,konst_value) + t_two(in_hash_buffer);
    endtask


    function automatic [63:0] SHR (input [63:0] data,input [5:0] shift);
        return data >> shift;
    endfunction

    function automatic [63:0] ROTR (input [63:0] data,input [5:0] shift);
        //logic last_bit;
        return ((data >> shift) | (data << (64-shift)));
    endfunction

    function automatic [63:0] sigma (input [63:0] data, input type_data);
        if(type_data) 
            return (ROTR(data,6'd19) ^ ROTR(data,6'd61) ^ SHR(data,6'd6));
        else 
            return (ROTR(data,6'd1) ^ ROTR(data,6'd8) ^ SHR(data,6'd7));
    endfunction


    task automatic word_cal (input [63:0] in_data[15:0],output array_80_64 word_data);
        // logic [1023:0] temp;
        // temp = in_data;
        for(int i=0;i<80;i++) begin
            if(i < 16) begin
                word_data[i] = in_data[i];
                //temp = temp << 64;
            end
            else begin
                word_data[i] = sigma(word_data[i-2],1) + word_data[i-7] + sigma(word_data[i-15],0) + word_data[i-16];
            end
        end
    endtask 


endpackage