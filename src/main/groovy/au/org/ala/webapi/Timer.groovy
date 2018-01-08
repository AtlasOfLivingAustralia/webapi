package au.org.ala.webapi

/**
 * Created by bea18c on 2/04/2014.
 */
final class Timer<T> {
    final T value

    final long start
    final long end

    Timer(T value, long start, long end) {
        this.value = value
        this.start = start
        this.end = end
    }

    static Timer<T> time(Closure<T> closure) {
        final long start = System.currentTimeMillis()
        final T value = closure.call()
        final long end = System.currentTimeMillis()
        return new Timer(value, start, end)
    }
}
