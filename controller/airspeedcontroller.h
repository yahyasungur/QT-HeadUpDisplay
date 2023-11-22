#ifndef AIRSPEEDCONTROLLER_H
#define AIRSPEEDCONTROLLER_H

#include <QObject>
#include <QTimer>

class AirspeedController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int currentAirspeed READ currentAirspeed WRITE setCurrentAirspeed NOTIFY currentAirspeedChanged)
public:
    explicit AirspeedController(QObject *parent = nullptr);
    int currentAirspeed() const;
    Q_INVOKABLE void updateAirspeed();

signals:
    void currentAirspeedChanged(int currentAirspeed);

public slots:
    void setCurrentAirspeed(int currentAirspeed);

private:
    int m_currentAirspeed;
    QTimer m_timer;
};

#endif // AIRSPEEDCONTROLLER_H
