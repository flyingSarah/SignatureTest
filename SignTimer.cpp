#include "SignTimer.h"

SignTimer::SignTimer(QObject *parent) : QObject(parent),
    m_signTime(0) {}

int SignTimer::getSignTime()
{
    if(m_timer.isValid())
    {
        return m_signTime;
    }
    return 0;
}

void SignTimer::setSignTime()
{
    m_signTime = m_timer.elapsed();
}

void SignTimer::start()
{
    m_signTime = 0;
    m_timer.start();
}

void SignTimer::stop()
{
    m_timer.invalidate();
}
