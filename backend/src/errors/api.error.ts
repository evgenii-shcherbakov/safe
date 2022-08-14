import {
  BadRequestException,
  HttpException,
  HttpStatus,
  UnauthorizedException,
} from '@nestjs/common';
import { ErrorMessage } from '../constants/enums';

export class ApiError extends HttpException {
  constructor(
    code: number = HttpStatus.INTERNAL_SERVER_ERROR,
    message: string = ErrorMessage.UNKNOWN,
  ) {
    super({ message }, code);
  }

  static badRequest(message: string = ErrorMessage.BAD_REQUEST) {
    throw new BadRequestException({ message });
  }

  static unauthorized(message: string = ErrorMessage.UNAUTHORIZED) {
    throw new UnauthorizedException({ message });
  }
}
