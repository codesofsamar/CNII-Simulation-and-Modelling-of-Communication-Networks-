#include <stdio.h>
#include <string.h>
#include <omnetpp.h>
#include <math.h>

class TxRx : public cSimpleModule
{
private:
    simtime_t lastArrivalTime;

    simsignal_t arrivalSignal;
    int count;
    cMessage *event;
    long long int c;

public:
    TxRx();
    virtual ~TxRx();
    long long int myNUM = pow(2,31);

protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual float LCG(float a, float b);


};

Define_Module(TxRx);

TxRx::TxRx()
{
    event = NULL;
}

TxRx::~TxRx()
{
    cancelAndDelete(event);
}

void TxRx::initialize()
{
    if (par("sender").boolValue() == true)
    {
        count = 0;
        event = new cMessage("event");
        scheduleAt(5.0, event);
//        c = par("seed");
        c = 2;
    }
    else
    {
        arrivalSignal = registerSignal("arrival");
    }
}
//float TxRx::LCG(float a, float b) {
//    float temp;
//    float uniform_1, uniform_2;
//    temp = (16807 * c) % (myNUM - 1);
//    uniform_1 = temp/(myNUM - 2);
//    uniform_2 = a + (b-a)*uniform_1;
//    c = temp; //update c
//    EV << "uniform_1:" << uniform_1 << endl;
//    EV << "uniform_2:" << uniform_2 << endl;
//    EV << "temp:" << temp << endl;
//    return uniform_2;
//}


void TxRx::handleMessage(cMessage *msg)
{
    if (msg == event)
    {
        int maxCount = par("maxCount");
        if(count < maxCount)
        {
            cMessage *msg = new cMessage("message");
            send(msg, "out");
            simtime_t delay; //= par("delayTime");

            if (par("random").boolValue() == true)
            {
                EV << "We are here -->" << endl;
                delay = LCG(0,2);
                EV << "LCG:Delay:" << delay << endl;
            }
            else
            {
                delay = par("delayTime");
            }

            //simtime_t  = par("delayTime");
            scheduleAt(simTime()+delay, event);
            count++;
        }
    }
    else
    {
        simtime_t currentTime = simTime();
        simtime_t interArrivalTime = currentTime - lastArrivalTime;
        lastArrivalTime = currentTime;

        emit(arrivalSignal, interArrivalTime);
        delete msg;
    }

}

float TxRx::LCG(float a, float b) {

    float uniform1, uniform2;
    static long long int temp;
    EV << "c:" << c << endl;
    temp = (16807*c)%(long long int)(pow(2,31) - 1);
    EV << "temp:" << temp << endl;
    uniform1 = temp/(pow(2,31) - 2);
    EV << "uniform1:" << uniform1 << endl;
    uniform2 = a + (b - a)*uniform1;
    EV << "uniform2:" << uniform2 << endl;
    c = temp;
    return uniform2;

}


//float TxRx::expo_distr(float a, float b) {
//
//}
