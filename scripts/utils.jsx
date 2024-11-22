function closePath(item) {
    if (item.closed) return;

    var points = item.pathPoints;
    var point = {
        start: points[0],
        end: points[points.length - 1]
    };

    if (!hasLeftHandle(point.start) && hasRightHandle(point.start)) {
        setLeftHandlePosition(point.start);
    }

    if (hasLeftHandle(point.end) && !hasRightHandle(point.end)) {
        setRightHandlePosition(point.end);
    }

    item.closed = true;
}
