/*
MIT License

Copyright (c) 2017 Boris Martin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QObject>

class GameData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int highscore READ highscore WRITE setHighscore NOTIFY highscoreChanged)
    Q_PROPERTY(int lastSpeed READ lastSpeed WRITE setLastSpeed NOTIFY lastSpeedChanged)
public:
    explicit GameData(QObject *parent = nullptr);

signals:
    void highscoreChanged();
    void lastSpeedChanged();
public slots:
    void doSave();
    int highscore() const {return m_highscore;}
    int lastSpeed() const {return m_lastSpeed;}
    void setHighscore(int score) {
        m_highscore = score;
        emit highscoreChanged();
    }
    void setLastSpeed(int speed) {
        m_lastSpeed = speed;
        emit lastSpeedChanged();
    }

private:
    int m_highscore = 0;
    int m_lastSpeed = 5;

};

#endif // GAMEDATA_H
