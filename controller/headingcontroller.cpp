#include "headingcontroller.h"

HeadingController::HeadingController(QObject *parent)
    : QObject(parent)
    , m_currentHeading(11)
{
    // connect the timer to the slot
    connect(&m_timer, &QTimer::timeout, this, &HeadingController::updateHeading);
    // start the timer
    m_timer.start(1000);
}

int HeadingController::currentHeading() const
{
    return m_currentHeading;
}

void HeadingController::updateHeading()
{
    if(m_currentHeading > 359)
    {
        m_currentHeading = 0;
    }
    else
    {
        setCurrentHeading (m_currentHeading + 1);
    }
}

void HeadingController::setCurrentHeading(int currentHeading)
{
    if (m_currentHeading == currentHeading)
        return;

    m_currentHeading = currentHeading;
    emit currentHeadingChanged(m_currentHeading);
}
