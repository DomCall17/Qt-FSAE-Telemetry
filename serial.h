#ifndef SERIAL_H
#define SERIAL_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QDebug>

class serial:public QObject
{
    Q_OBJECT
public:
    explicit serial(const QString &portName, int baudrate, QObject* parent = nullptr);
    void setup(const QString &portName, int baudRate);

private slots:
    void onreadyRead();

signals:
    void errorOccurred(QString message);
    void dataReceived(const QByteArray data);

private:
    QSerialPort serialdata;
    QByteArray buffer;
    QByteArray data;
};

#endif // SERIAL_H
