#include "parse.h"

parse::parse(QObject *parent) : QObject(parent) {
}

void parse::storeit(const QByteArray &data)
{
    QJsonParseError error;

    doc = QJsonDocument::fromJson(data, &error);

    // If parsing fails, report error
    if (error.error != QJsonParseError::NoError){
        emit errorOccurred("JSON parse error: " + error.errorString());
        return;
    }

    // If it's not a JSON object, skip it
    if (!doc.isObject()){
        emit errorOccurred("Received JSON is not an object");
        return;
    }


    object = doc.object();

    setSpeed(object.value("speed").toInt());
    setThrtl(object.value("throttle").toInt());
    setBrake(object.value("brake").toInt());
    setBattTemp(object.value("BatteryTemp").toInt());
    setMotorTemp(object.value("motorTemp").toInt());
    setVolt(object.value("voltage").toInt());
    setRpm(object.value("rpm").toInt());
    setBatt(object.value("battery").toInt());
    setLaps(object.value("laps").toInt());
    setBattCurr(object.value("batteryCurrent").toInt());
    setDist(object.value("distance").toInt());



}
