import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Observable } from 'rxjs';
import { LOCAL_SECRET_KEY } from '../constants/common';
import { ApiError } from '../errors/api.error';

const actionMethods: string[] = ['GET', 'POST', 'PUT', 'DELETE'];

@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();

    if (request.method && !actionMethods.includes(request.method.toUpperCase())) {
      return true;
    }

    try {
      const authHeader: string | undefined = request.headers.authorization;

      if (authHeader !== (process.env.SECRET_KEY || LOCAL_SECRET_KEY)) {
        ApiError.unauthorized();
      }

      return true;
    } catch (e) {
      ApiError.unauthorized();
    }
  }
}
