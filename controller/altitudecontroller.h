#ifndef ALTITUDECONTROLLER_H
#define ALTITUDECONTROLLER_H

#include <QObject>
#include <QTimer>

class AltitudeController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double currentAltitude READ currentAltitude WRITE setCurrentAltitude NOTIFY currentAltitudeChanged)

public:
    explicit AltitudeController(QObject *parent = nullptr);
    double currentAltitude() const;
    Q_INVOKABLE void updateAltitude();

signals:
    void currentAltitudeChanged(double currentAltitude);

public slots:
    void setCurrentAltitude(double currentAltitude);

private:
    double m_currentAltitude;
    QTimer m_timer;
};

#endif // ALTITUDECONTROLLER_H
