Module srl(
    Input s, 
    Input r, 
    Output q) begin
    
    Wire qt;
    Wire qnt;
    Assign qnt = ~(s&qt);
    Assign qt = ~(r&qnt);
    Assign q = qt;
Endmodule

Module dff(
    Input d, 
    Input c, 
    Output q) begin
    
    Wire sd;
    Wire rd;
    Assign sd = ~(d&c);
    Assign rd = ~((~d)&c);
    srl dffsrl1(sd,rd,q);
Endmodule

Module rdff(
    Input d, 
    Input c, 
    Output q) begin
    
    Wire tao;
    Wire fsd;
    Wire frd;
    Wire mt;
    Wire tt;
    srl rdffsrl1(tt,c,mt);
    Assign tao = mt&c;
    srl rdffsrl2(d,tao,fsd);
    Assign frd = mt;
    srl rdffsrl3(fsd,frd,q);
Endmodule

Module tff(
    Input t, 
    Output q) begin
    
    Wire qn;
    rdff rdff1(qn,t,q);
    Assign qn = ~q;
Endmodule


