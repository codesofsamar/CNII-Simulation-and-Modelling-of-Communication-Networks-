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
import inet.nodes.ethernet.EtherSwitch;
import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;
import inet.nodes.inet.WirelessHost;
import inet.nodes.wireless.AccessPoint;
import inet.world.radio.ChannelControl;
import ned.DatarateChannel;


network Network
{
    @display("bgb=635,247");
    types:
        channel etherline extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 10Mbps;
        }

    submodules:
        StationA: WirelessHost {
            @display("p=91,68;is=l");
        }
        accessPoint: AccessPoint {
            @display("p=81,131");
        }

        StationB: StandardHost {
            @display("p=490,127");
        }
        flatNetworkConfigurator: FlatNetworkConfigurator {
            @display("p=311,18");
        }
        router: Router {
            @display("p=271,101");
        }

        switch: EtherSwitch {
            @display("p=271,177");
        }
        channelControl: ChannelControl {
            @display("p=445,42");
        }
    connections:
        //accessPoint.ethg++ <--> router.ethg++;
        // router is for the later part
        //router.pppg++ <--> StationB.pppg++;
        //we use switch for the first task
        accessPoint.ethg++ <--> etherline <-->switch.ethg++;
        //switch.pppg++ <--> StationB.pppg++;
        switch.ethg++ <--> etherline <--> StationB.ethg++;
        //accessPoint.ethg++<--> etherline <--> StationA.ethg++;

}

