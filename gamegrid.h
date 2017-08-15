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
#ifndef GAMEGRID_H
#define GAMEGRID_H

#include <QList>

/** @brief Class storing the data on a Grid.
 *
 *  This class stores the state of a square Snake Grid, with a constant 2D size, safe access, food generation option,...
 *
 *
 * */
class GameGrid : public QObject
{

    Q_OBJECT
public:
    GameGrid(quint32 w = 12, quint32 h = 8);

    enum CELL_STATE {EMPTY, SNAKE, FOOD};

    const quint32 width;
    const quint32 height;

public slots:
    /**
     * @brief read cell state at particular coordinates
     * @param x : absciss, such as 0 <= x < width
     * @param y : ordinate, such as 0 <= x < heigth
     * @return state at this cell, CELL_STATE::EMPTY if out of bound.
     */
    CELL_STATE at(quint32 x, quint32 y) const;

    /**
     * @brief switch an empty cell to FOOD state, randomly
     */
    void addFood();

signals:
    /**
     * @brief emitted when data changes. Parameter is the ID of the cell changed, -1 if more than one changed.
     */
    void changed(int);

private:
    QList<CELL_STATE> data;
};

#endif // GAMEGRID_H
