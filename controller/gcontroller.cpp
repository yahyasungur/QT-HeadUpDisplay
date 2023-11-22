#include "gcontroller.h"

GController::GController(QObject *parent)
    : QObject(parent)
    , m_currentG(3.2)
{
    // connect the timer to the slot
    connect(&m_timer, &QTimer::timeout, this, &GController::updateG);
    // start the timer
    m_timer.start(1000);

}

double GController::currentG() const
{
    return m_currentG;
}

void GController::updateG()
{
    if(m_currentG > 9.1)
    {
        m_currentG = 2.1;
    }
    else
    {
        int newG = round ((m_currentG + 0.1)*10);
        setCurrentG(newG/10.0);
    }
}

void GController::setCurrentG(double currentG)
{
    if (qFuzzyCompare(m_currentG, currentG))
        return;

    m_currentG = currentG;
    emit currentGChanged(m_currentG);
}
