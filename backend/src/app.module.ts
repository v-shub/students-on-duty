import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './users/users.module';
import { StudentsModule } from './students/students.module';
import { GroupsModule } from './groups/groups.module';
import { DutyTypesModule } from './duty-types/duty-types.module';
import { DutySchedulesModule } from './duty-schedules/duty-schedules.module';
import { DutyEventsModule } from './duty-events/duty-events.module';
import { DutyDaysModule } from './duty-days/duty-days.module';
import { AbsencesModule } from './absences/absences.module';
import { StudentsGroupsModule } from './students-groups/students-groups.module';


@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT || '5432', 10),
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      database: process.env.DATABASE,
      entities: [__dirname + '/**/entities/*.entity{.ts,.js}'],
      synchronize: false,
      ssl: { rejectUnauthorized: false },
      logging: true,
    }),
    UsersModule,
    StudentsModule,
    GroupsModule,
    DutyTypesModule,
    DutySchedulesModule,
    DutyEventsModule,
    DutyDaysModule,
    AbsencesModule,
    StudentsGroupsModule,
  ],
})
export class AppModule {}