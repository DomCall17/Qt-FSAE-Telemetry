#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "parse.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //change the serialport and baudrate here
    serial serial("COM4",115200);
    parse parser;

    // connecting serial to parse
    QObject::connect(&serial,&serial::dataReceived,&parser,&parse::storeit);

    // shows the json stuff on application output
    QObject::connect(&serial, &serial::dataReceived, [](const QByteArray &ba){
        qDebug() << "[serial] line:" << ba;
   });

    QObject::connect(&serial, &serial::errorOccurred, [](const QString& m){
        qWarning() << "[serial error]" << m;
    });

    engine.rootContext()->setContextProperty("parser", &parser);


    engine.load(QUrl::fromLocalFile("C:/Users/domin/OneDrive/Documents/dashhh/Main.qml"));


    if (engine.rootObjects().isEmpty()) return -1;
    return app.exec();
}
