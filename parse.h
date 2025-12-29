#ifndef PARSE_H
#define PARSE_H

#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <serial.h>
#include <QDebug>


class parse:public QObject
{
    Q_OBJECT

    Q_PROPERTY(int speed READ getSpeed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int thrtl READ getThrtl WRITE setThrtl NOTIFY thrtlChanged)
    Q_PROPERTY(int brake READ getBrake WRITE setBrake NOTIFY brakeChanged)
    Q_PROPERTY(int battTemp READ getBattTemp WRITE setBattTemp NOTIFY battTempChanged)
    Q_PROPERTY(int motorTemp READ getMotorTemp WRITE setMotorTemp NOTIFY motorTempChanged)
    Q_PROPERTY(int volt READ getVolt WRITE setVolt NOTIFY voltChanged)
    Q_PROPERTY(int rpm READ getRpm WRITE setRpm NOTIFY rpmChanged)
    Q_PROPERTY(int batt READ getBatt WRITE setBatt NOTIFY battChanged)
    Q_PROPERTY(int laps READ getLaps WRITE setLaps NOTIFY lapsChanged)
    Q_PROPERTY(int battCurr READ getBattCurr WRITE setBattCurr NOTIFY battCurrChanged)
    Q_PROPERTY(int dist READ getDist WRITE setDist NOTIFY distChanged)

public:
    parse(QObject* parent = nullptr);

    //setter and getter
    int getSpeed() const { return speed; }
    void setSpeed(int value) { if (value == speed) return; speed = value; emit speedChanged(); }

    int getThrtl() const { return thrtl; }
    void setThrtl(int value) { if (value == thrtl) return; thrtl = value; emit thrtlChanged(); }

    int getBrake() const { return brake; }
    void setBrake(int value) { if (value == brake) return; brake = value; emit brakeChanged(); }

    int getBattTemp() const { return battTemp; }
    void setBattTemp(int value) { if (value == battTemp) return; battTemp = value; emit battTempChanged(); }

    int getMotorTemp() const { return motorTemp; }
    void setMotorTemp(int value) { if (value == motorTemp) return; motorTemp = value; emit motorTempChanged(); }

    int getVolt() const { return volt; }
    void setVolt(int value) { if (value == volt) return; volt = value; emit voltChanged(); }

    int getRpm() const { return rpm; }
    void setRpm(int value) { if (value == rpm) return; rpm = value; emit rpmChanged(); }

    int getBatt() const { return batt; }
    void setBatt(int value) { if (value == batt) return; batt = value; emit battChanged(); }

    int getLaps() const { return laps; }
    void setLaps(int value) { if (value == laps) return; laps = value; emit lapsChanged(); }

    int getBattCurr() const { return battCurr; }
    void setBattCurr(int value) { if (value == battCurr) return; battCurr = value; emit battCurrChanged(); }

    int getDist() const { return dist; }
    void setDist(int value) { if (value == dist) return; dist = value; emit distChanged(); }


public slots:
    void storeit(const QByteArray &data);

signals:
    void errorOccurred(QString message);

    void speedChanged();
    void thrtlChanged();
    void brakeChanged();
    void battTempChanged();
    void motorTempChanged();
    void voltChanged();
    void rpmChanged();
    void battChanged();
    void lapsChanged();
    void battCurrChanged();
    void distChanged();


private:
    QJsonDocument doc;
    QJsonObject object;

    int speed = 0;
    int thrtl = 0;
    int brake = 0;
    int battTemp = 25;
    int motorTemp = 30;
    int volt = 0;
    int rpm = 0;
    int batt = 100;
    int laps = 0;
    int battCurr = 10;
    int dist = 0;
};

#endif // PARSE_H
