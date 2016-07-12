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
import inet.networklayer.autorouting.ipv4.FlatNetworkConfigurator;
import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;


module clientNet
{
    parameters:
        int h; // number of client connections to router
    gates:
        inout pppg;
    submodules:
        clients[h]: StandardHost;
        router: Router;
    connections:
        for i=0..h-1 {
            clients[i].pppg++ <--> {  delay = 40ms; datarate = 64kbps; ber = 1/10000000; } <--> router.pppg++;
        }
        pppg <--> router.pppg++;
}

module routerNet
{
    parameters:
        int h; // number of clientNets per router
    gates:
        inout pppg;
    submodules:
        clientNets[h]: clientNet;
        router: Router;
    connections:
        for i=0..h-1 {
            clientNets[i].pppg <--> {  delay = 15ms; datarate = 2Mbps; ber = 1/10000000; } <--> router.pppg++;
        }

        pppg <--> router.pppg++;
}


network Network
{
    parameters:
        int h; // number of routers on gateway
        @display("bgb=319,343");
    submodules:
        flatNetworkConfigurator: FlatNetworkConfigurator;
        routerNets[h]: routerNet;
        router: Router;
        server: StandardHost;
    connections:
        for i=0..h-1 {
            routerNets[i].pppg <--> {  delay = 15ms; datarate = 10Mbps; ber = 1/10000000; } <--> router.pppg++;
        }
        router.pppg++ <--> {  delay = 0ms; datarate = 1000Mbps; } <--> server.pppg++;
}

