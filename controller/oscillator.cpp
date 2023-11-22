#include "oscillator.h"

Oscillator::Oscillator(QObject *parent)
    : QObject(parent)
    , mValue(0)
    , mMinimum(0)
    , mMaximum(360)
    , mPeriod(30)
    , mInitialValue(0)
    , mDelta(0)
    , mTimeout(50)
    , m_plusMinusOscillator(0)
{
}

bool positiveOscilate = true;

void Oscillator::updatePlusMinusOscillator()
{
    if(m_plusMinusOscillator > 250) positiveOscilate = false;
    else if(m_plusMinusOscillator < -250) positiveOscilate = true;

    positiveOscilate ? setPlusMinusOscillator (m_plusMinusOscillator + 5) : setPlusMinusOscillator (m_plusMinusOscillator - 5);
}

void Oscillator::start()
{
    mDelta = mTimeout * (mMaximum - mMinimum) / (1000 * mPeriod);
    mSign = 1;

    if (mInitialValue < mMinimum || mMaximum < mInitialValue)
        mInitialValue = mMinimum + (mMaximum - mMinimum) / 2.0;

    mValue = mInitialValue;

    connect(&mTimer, &QTimer::timeout, this, &Oscillator::tick);
    connect(&mTimer, &QTimer::timeout, this, &Oscillator::updatePlusMinusOscillator);
    mTimer.start(mTimeout);
}

void Oscillator::stop()
{
    mTimer.stop();
}

void Oscillator::tick()
{
    mValue += mSign * mDelta;

    if (mValue > mMaximum)
    {
        mValue -= mMaximum;
    }

    emit valueChanged();
}

void Oscillator::setPlusMinusOscillator(int plusMinusOscillator)
{
    if (m_plusMinusOscillator == plusMinusOscillator)
        return;

    m_plusMinusOscillator = plusMinusOscillator;
    emit plusMinusOscillatorChanged(m_plusMinusOscillator);
}

float Oscillator::value() const
{
    return mValue;
}

void Oscillator::setValue(float newValue)
{
    if (qFuzzyCompare(mValue, newValue))
        return;
    mValue = newValue;
    emit valueChanged();
}

float Oscillator::minimum() const
{
    return mMinimum;
}

void Oscillator::setMinimum(float newMinimum)
{
    if (qFuzzyCompare(mMinimum, newMinimum))
        return;
    mMinimum = newMinimum;
    emit minimumChanged();
}

float Oscillator::maximum() const
{
    return mMaximum;
}

void Oscillator::setMaximum(float newMaximum)
{
    if (qFuzzyCompare(mMaximum, newMaximum))
        return;
    mMaximum = newMaximum;
    emit maximumChanged();
}

float Oscillator::period() const
{
    return mPeriod;
}

void Oscillator::setPeriod(float newPeriod)
{
    if (qFuzzyCompare(mPeriod, newPeriod))
        return;
    mPeriod = newPeriod;
    emit periodChanged();
}

float Oscillator::initialValue() const
{
    return mInitialValue;
}

void Oscillator::setInitialValue(float newInitialValue)
{
    if (qFuzzyCompare(mInitialValue, newInitialValue))
        return;
    mInitialValue = newInitialValue;
    emit initialValueChanged();
}

int Oscillator::plusMinusOscillator() const
{
    return m_plusMinusOscillator;
}

