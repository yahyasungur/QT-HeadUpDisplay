#include "altitudecontroller.h"
#include <math.h>
#include <stdlib.h>

AltitudeController::AltitudeController(QObject *parent)
    : QObject(parent)
    , m_currentAltitude(3.1)
{
    // connect to the timer to the slot
    connect(&m_timer, &QTimer::timeout, this, &AltitudeController::updateAltitude);
    m_timer.start(1000);
}

double AltitudeController::currentAltitude() const
{
    return m_currentAltitude;
}

void AltitudeController::updateAltitude()
{
    if (m_currentAltitude > 99.1)
    {
        m_currentAltitude = 3.1;
    } 
    else
    {
        int newAltitude = (int)((m_currentAltitude + 0.7)*10);
        setCurrentAltitude(newAltitude/10.0);
    }
}

void AltitudeController::setCurrentAltitude(double currentAltitude)
{
    if (qFuzzyCompare(m_currentAltitude, currentAltitude))
        return;

    m_currentAltitude = currentAltitude;
    emit currentAltitudeChanged(m_currentAltitude);
}
