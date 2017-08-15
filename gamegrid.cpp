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
#include "gamegrid.h"

GameGrid::GameGrid(quint32 w, quint32 h) : width(w), height(h)
{
    //Valid input : non-null size
    Q_ASSERT(w);
    Q_ASSERT(h);

    auto gridSize = width * height;
    for (quint32 i = 0; i < gridSize; ++i) {
        data.append(EMPTY);
    }

    Q_ASSERT(quint32(data.length()) == gridSize);
}

GameGrid::CELL_STATE GameGrid::at(quint32 x, quint32 y) const {
    if (x >= width || y >= height)
        return EMPTY;

    quint32 coord = x + y * width;
    Q_ASSERT(coord < quint32(data.length())); //Mathematically obvious.

    return data.at(coord);
}

void GameGrid::addFood() {
    QList<quint32> emptyCells;

    //Gather all IDs of empty cells
    for (quint32 i = 0; i < width * height; ++i) {
        if (data.at(i) == EMPTY)
            emptyCells.append(i);
    }

    //Pick one randomly, make it a FOOD cell, signal the change
    int id = qrand() % emptyCells.length();
    data[id] = FOOD;
    emit changed(id);
}
