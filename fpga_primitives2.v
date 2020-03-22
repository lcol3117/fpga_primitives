module srl(
    input s, 
    input r, 
    output q
    );
    wire qt;
    wire qnt;
	 wire inrace;
	 wire atqnt;
	 assign inrace = qt&qnt;
	 assign atqnt = r|inrace;
    assign qnt = ~(atqnt&qt);
    assign qt = ~(s&qnt);
    assign q = qt;
	 
endmodule

module rdff(
    input d, 
    input c, 
    output q
    );
	 wire ca;
	 wire tdb;
	 wire cb;
	 wire trdffq;
	 wire invclk;
	 assign invclk = ~c;
	 assign ca = invclk;
	 assign cb = ~invclk;
	 dff rdffdff1 (d,ca,tdb);
	 dff rdffdff2 (tdb,cb,trdffq);
	 assign q = trdffq;
	 
endmodule

module dff(
	 input d,
	 input c,
	 output q
	 );
	 wire srl1;
	 wire srl2;
	 wire tq;
	 assign srl1 = (d&c);
	 assign srl2 = ((~d)&c);
	 srl dffsrl (srl1,srl2,tq);
	 assign q = tq;
	 
endmodule

module tff(
	 input t,
	 output q
	 );
	 wire rev;
	 wire toq;
	 rdff trdff (rev,t,toq);
	 assign rev = ~toq;
	 assign q = toq;
	 
endmodule

module bcfour(
	 input i,
	 output soa,
	 output sob,
	 output soc,
	 output sod
	 );
	 wire fab;
	 wire fbc;
	 wire fcd;
	 wire tod;
	 tff fctff1 (i,fab);
	 tff fctff2 (fab,fbc);
	 tff fctff3 (fbc,fcd);
	 tff fctff4 (fcd,tod);
	 assign soa = fab;
	 assign sob = fbc;
	 assign soc = fcd;
	 assign sod = tod;
	 
endmodule

module rbcfour(
	 input si,
	 input srst,
	 input syclk,
	 output sfoa,
	 output sfob,
	 output sfoc,
	 output sfod
	 );
	 wire cnrst;
	 wire crst;
	 wire acbcfd;
	 wire snrstd;
	 wire fsfoa;
	 wire fsfob;
	 wire fsfoc;
	 wire fsfod;
	 assign cnrst = (~srst)&si;
	 assign crst = srst&(syclk&(snrstd));
	 assign acbcfd = crst|cnrst;
	 bcfour sfrbcf (acbcfd,fsfoa,fsfob,fsfoc,fsfod);
	 assign snrstd = (fsfoa|fsfob)|(fsfoc|fsfod);
	 assign sfoa = fsfoa;
	 assign sfob = fsfob;
	 assign sfoc = fsfoc;
	 assign sfod = fsfod;
	 
endmodule
