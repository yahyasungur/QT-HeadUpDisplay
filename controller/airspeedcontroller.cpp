#include "airspeedcontroller.h"

AirspeedController::AirspeedController(QObject *parent)
    : QObject(parent)
    , m_currentAirspeed(152)
{
     // connect the timer to the slot
     connect(&m_timer, &QTimer::timeout, this, &AirspeedController::updateAirspeed);
     // start the timer
     m_timer.start(1000);
}

int AirspeedController::currentAirspeed() const
{
    return m_currentAirspeed;
}

void AirspeedController::updateAirspeed()
{
    if(m_currentAirspeed > 999)
    {
        m_currentAirspeed = 0;
    }
    else
    {
        setCurrentAirspeed (m_currentAirspeed + 9);
    }
}

void AirspeedController::setCurrentAirspeed(int currentAirspeed)
{
    if (m_currentAirspeed == currentAirspeed)
        return;

    m_currentAirspeed = currentAirspeed;
    emit currentAirspeedChanged(m_currentAirspeed);
}
