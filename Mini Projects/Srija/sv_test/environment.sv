class environment;
  mailbox gen2driv;
  mailbox mon2sco;
  mailbox mon2cov;
  generator gen;
  driver driv;
  monitor mon;
  scoreboard sco;
  coverage c_h;
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif=vif;
    gen2driv=new();
    mon2sco=new();
    mon2cov=new();
    gen=new(gen2driv);
    driv=new(gen2driv,vif);
    mon=new(mon2sco,vif,mon2cov);
    sco=new(mon2sco);
    c_h=new(mon2cov);
    
  endfunction
  
  task main();
    $display("display the environment");
    fork
      gen.put_msg();
      driv.get_msg();
      mon.put_msg();
      sco.get_msg();
      c_h.cov_run();
    join
  endtask
endclass

  
  