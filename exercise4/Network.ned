//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package clientserver;
import inet.linklayer.ppp.PPP;
import inet.networklayer.autorouting.ipv4.FlatNetworkConfigurator;
import inet.nodes.inet.StandardHost;


//
// TODO documentation
//
network Network
{
    @display("bgb=635,247");
    types:
       
      //Implement channel here
//      datarate, delay and ber 
    submodules:
        client: StandardHost {
            @display("p=71,71;is=l");
        }
        server: StandardHost {
            @display("p=568,71");
        }
        flatNetworkConfigurator: FlatNetworkConfigurator {
            @display("p=311,18");
        }
    connections:
//        client.pppg++ <--> server.pppg++;
          client.pppg++ <-->{delay=200ms; datarate=1Mbps; ber=1/10000000;}<--> server.pppg++;
//        client.
       
         
}

