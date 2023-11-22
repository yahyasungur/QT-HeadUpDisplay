#include "aimcursorcontroller.h"

AimCursorController::AimCursorController(QObject *parent)
    : QObject(parent)
    , m_cursorDeviationX(0)
    , m_cursorDeviationY(0)
{
    connect(&m_timer, &QTimer::timeout, this, &AimCursorController::updateDeviation);
    m_timer.start(50);
}

bool negativeFlagX = false;
bool negativeFlagY = false;
int counter = 0;

void AimCursorController::updateDeviation()
{
    if(m_cursorDeviationX > 100) negativeFlagX = true;
    else if (m_cursorDeviationX < -100) negativeFlagX = false;

    if(m_cursorDeviationY > 100) negativeFlagY = true;
    else if (m_cursorDeviationY < -100) negativeFlagY = false;

    if(counter > 35){
        rand() % 2 == 0 ? negativeFlagX = true : negativeFlagX = false;
        rand() % 2 == 0 ? negativeFlagY = true : negativeFlagY = false;
        counter = 0;
    }

    counter++;

    negativeFlagX ? setCursorDeviationX (m_cursorDeviationX - 5) : setCursorDeviationX (m_cursorDeviationX + 5);
    negativeFlagY ? setCursorDeviationY (m_cursorDeviationY - 5) : setCursorDeviationY (m_cursorDeviationY + 5);
}

int AimCursorController::cursorDeviationX() const
{
    return m_cursorDeviationX;
}

int AimCursorController::cursorDeviationY() const
{
    return m_cursorDeviationY;
}

void AimCursorController::setCursorDeviationX(int cursorDeviationX)
{
    if (m_cursorDeviationX == cursorDeviationX)
        return;

    m_cursorDeviationX = cursorDeviationX;
    emit cursorDeviationXChanged(m_cursorDeviationX);
}

void AimCursorController::setCursorDeviationY(int cursorDeviationY)
{
    if (m_cursorDeviationY == cursorDeviationY)
        return;

    m_cursorDeviationY = cursorDeviationY;
    emit cursorDeviationYChanged(m_cursorDeviationY);
}
