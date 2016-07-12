//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 2003-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//


simple TxRx
{
    parameters:
        volatile double delayTime @unit(s) = default(0);   // delay before sending back message
        bool sender = default(false);
        bool random = default(false);
        volatile int seed = default(2);
        volatile int maxCount = default(1000);
        @display("i=block/routing");
    gates:
        input in;
        output out;
}

network exercise2
{
    submodules:
        tx: TxRx {
            parameters:
                @display("i=,cyan");
                sender = true;
                
        }
        rx: TxRx {
            parameters:
                @display("i=,gold");
                sender = false;
                
            	@signal[arrival](type="long");
        		@statistic[interArrivalTime](title="inter-arrival time"; source="arrival"; record=vector,stats,histogram; interpolationmode=none);
                
                
        }
    connections:
        tx.out --> {  delay = 100ms; } --> rx.in;
        rx.out --> {  delay = 100ms; } --> tx.in;
}

