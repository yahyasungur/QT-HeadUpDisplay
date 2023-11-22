#ifndef LADDERCONTROLLER_H
#define LADDERCONTROLLER_H

#include <QObject>
#include <QTimer>

class LadderController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int pitchValue READ pitchValue WRITE setPitchValue NOTIFY pitchValueChanged)
public:
    explicit LadderController(QObject *parent = nullptr);
    int pitchValue() const;
    Q_INVOKABLE void updatePitchValue ();

signals:
    void pitchValueChanged(int pitchValue);

public slots:
    void setPitchValue(int pitchValue);

private:
    int m_pitchValue;
    QTimer m_timer;
};

#endif // LADDERCONTROLLER_H
