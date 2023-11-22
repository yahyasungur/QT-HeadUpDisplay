#include "laddercontroller.h"

LadderController::LadderController(QObject *parent) 
    : QObject(parent)
    , m_pitchValue(39)
{
     // connect the timer to the slot
     connect(&m_timer, &QTimer::timeout, this, &LadderController::updatePitchValue);
     // start the timer
     m_timer.start(1000);
}

int LadderController::pitchValue() const
{
    return m_pitchValue;
}

void LadderController::setPitchValue(int pitchValue)
{
    if (m_pitchValue == pitchValue)
    {
        return;
    }

    m_pitchValue = pitchValue;
    emit pitchValueChanged(m_pitchValue);
}

void LadderController::updatePitchValue()
{
    if (m_pitchValue == 180)
    {
        setPitchValue(0);
    }
    else
    {
        setPitchValue(m_pitchValue + 1);
    }
}
