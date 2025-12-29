#include "serial.h"



serial::serial(const QString &portName, int baudRate, QObject *parent): QObject(parent)
{
    setup(portName,baudRate);

    QObject::connect(&serialdata,&QSerialPort::readyRead,this,&serial::onreadyRead);


}

void serial::setup(const QString& portName, int baudRate)
{
   if (serialdata.isOpen())
        serialdata.close();

    serialdata.setPortName(portName);
    serialdata.setBaudRate(baudRate);
    serialdata.setDataBits(QSerialPort::Data8);
    serialdata.setParity(QSerialPort::NoParity);
    serialdata.setStopBits(QSerialPort::OneStop);
    serialdata.setFlowControl(QSerialPort::NoFlowControl);

    qDebug() << "Opening" << portName << "@" << baudRate;

    //checks if the port is open
    if (!serialdata.open(QSerialPort::ReadOnly))
        emit errorOccurred(QStringLiteral("Cannot open %1: %2").arg(portName, serialdata.errorString()));

}

void serial::onreadyRead()
{


    //aa from serial
    buffer.append(serialdata.readAll());


    int newlineIndex;

    while((newlineIndex = buffer.indexOf('\n')) != -1){

        //transfer complete stuff into data
        data = buffer.left(newlineIndex).trimmed();

        //remove completed stuff after transfered in buffer
        buffer.remove(0, newlineIndex + 1);

        if (data.isEmpty()){
            //data has nothing in it
            qDebug() << "not receiving anything :(";
            continue;
        }else
            //transfer data to parse class
            emit dataReceived(data);
    }
}

