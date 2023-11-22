#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <controller/laddercontroller.h>
#include <controller/airspeedcontroller.h>
#include <controller/oscillator.h>
#include <controller/altitudecontroller.h>
#include <controller/aimcursorcontroller.h>
#include <controller/gcontroller.h>
#include <controller/headingcontroller.h>
#include <controller/systemcontroller.h>

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    LadderController m_ladderController;
    AirspeedController m_airspeedController;
    Oscillator m_osscillator;
    AltitudeController m_altitudeController;
    AimCursorController m_aimCursorController;
    GController m_gController;
    HeadingController m_headingController;
    SystemController m_systemController;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    QQmlContext * context(engine.rootContext ());
    context->setContextProperty ("ladderController", &m_ladderController);
    context->setContextProperty ("airspeedController", &m_airspeedController);
    context->setContextProperty ("osscillatorController", &m_osscillator);
    context->setContextProperty ("altitudeController", &m_altitudeController);
    context->setContextProperty ("aimCursorController", &m_aimCursorController);
    context->setContextProperty ("gController", &m_gController);
    context->setContextProperty ("headingController", &m_headingController);
    context->setContextProperty ("systemController", &m_systemController);

    engine.load(url);

    return app.exec();
}
