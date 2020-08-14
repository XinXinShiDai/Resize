module Resize(
    clk,
    rst_n,
    Din_Valid, // �������룻tvalid��
    Cal_Valid, // ��Ч������
    Din, // ��������;
    Dout // ���������
    );
	
    input clk;
    input rst_n;
    input Din_Valid;
    input Cal_Valid;
    input Din;
    output reg Dout;

    // ��ֵ�������뵽��ͱ���λ�У�

    reg [193:0] line_buffer; // 128*64 ����ͼ���л�������
    reg [3:0] window_buffer; // 2*2 ���ڵĴ���������            
    
    // Data Buffer
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
                line_buffer   <= 194'd0; // 64*3+2=194;
                window_buffer <= 	4'b0000; // 2*2=4��
        end
        else begin
        	if(Din_Valid) begin
                line_buffer      <= {line_buffer[192:0],Din}; // �������룬������λ��
                window_buffer[3] <= line_buffer[129]; // ������ʾ��ȡ�ڶ��к͵����У�
                window_buffer[2] <= line_buffer[128];
                window_buffer[1] <= line_buffer[65];
                window_buffer[0] <= line_buffer[64];
            end
            else begin
            	line_buffer   <= line_buffer;
            	window_buffer <= window_buffer;
            end
            	
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            Dout <= 1'b0;
        else begin
            if(Cal_Valid) begin
            case(window_buffer) // ���ڲ��������ڵ��ڶ���һ��Ϊһ����֮Ϊ�㣻
                4'b0000: Dout <= 1'b0;
                4'b0001: Dout <= 1'b0;
                4'b0010: Dout <= 1'b0;
                4'b0011: Dout <= 1'b1;
                4'b0100: Dout <= 1'b0;
                4'b0101: Dout <= 1'b1;
                4'b0110: Dout <= 1'b1;
                4'b0111: Dout <= 1'b1;
                4'b1000: Dout <= 1'b0;
                4'b1001: Dout <= 1'b1;
                4'b1010: Dout <= 1'b1;
                4'b1011: Dout <= 1'b1;
                4'b1100: Dout <= 1'b1;
                4'b1101: Dout <= 1'b1;
                4'b1110: Dout <= 1'b1;
                default: Dout <= 1'b1;
            endcase
            end
            else 
                Dout <= 1'b0;
        end
    end

endmodule