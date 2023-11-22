#include "systemcontroller.h"
#include <QDateTime>

SystemController::SystemController(QObject *parent) : QObject(parent)
{
    m_CurrentTimeTimer = new QTimer(this);
    m_CurrentTimeTimer->setInterval (500);
    m_CurrentTimeTimer->setSingleShot (true);
    connect (m_CurrentTimeTimer, &QTimer::timeout, this, &SystemController::currentTimeTimerTimeout);

    currentTimeTimerTimeout ();
}

QString SystemController::currentTime() const
{
    return m_currentTime;
}

void SystemController::setCurrentTime(QString currentTime)
{
    if (m_currentTime == currentTime)
        return;

    m_currentTime = currentTime;
    emit currentTimeChanged(m_currentTime);
}

void SystemController::currentTimeTimerTimeout()
{
    QDateTime dateTime;
    QString currentTime = dateTime.currentDateTime ().toString ("HH:MM AP  |  ddd, MMM dd, yyyy");

    setCurrentTime (currentTime);

    m_CurrentTimeTimer->start ();
}
