package au.org.ala.webapi
/**
 * Created by bea18c on 18/03/14.
 */
abstract class Try<T> {

    static Try<T> apply(Closure<T> closure) {
        try {
            final def result = closure.call()
            return new Success(result)
        } catch (Exception e) {
            return new Failure<T>(e)
        }
    }
}

final class Success<T> extends Try<T> {
    final T value;
    Success(T value) {
        this.value = value
    }
}

final class Failure<T> extends Try<T> {
    final Exception exception
    Failure(Exception exception) {
        this.exception = exception
    }
}